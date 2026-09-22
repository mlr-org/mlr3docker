#!/usr/bin/env Rscript
# Dumps the R library of the image this script runs in as JSON.
#
# Usage (inside the image):
#   Rscript extract-packages.R mlrorg/mlr3-book:latest > packages.json
#
# Only base R is used so the script does not depend on the library it inspects.

args = commandArgs(trailingOnly = TRUE)
image = if (length(args)) args[[1L]] else Sys.getenv("IMAGE", "unknown")

fields = c("Repository", "RemoteType", "RemoteUsername", "RemoteRepo", "RemoteRef",
  "RemoteSha", "RemoteUrl", "RemotePkgRef", "RemoteRepos")
ip = installed.packages(fields = fields, noCache = TRUE)
ip = ip[!duplicated(ip[, "Package"]), , drop = FALSE]
ip = ip[order(tolower(ip[, "Package"])), , drop = FALSE]

value = function(row, field) {
  x = if (field %in% names(row)) row[[field]] else NA_character_
  if (is.na(x) || !nzchar(trimws(x))) NA_character_ else trimws(x)
}

# Origin of a package: short source label, a detail ref and a link.
origin = function(row) {
  priority = value(row, "Priority")
  type = value(row, "RemoteType")
  repository = value(row, "Repository")
  repos = value(row, "RemoteRepos")

  if (!is.na(type) && type == "github") {
    slug = paste(c(value(row, "RemoteUsername"), value(row, "RemoteRepo")), collapse = "/")
    sha = value(row, "RemoteSha")
    ref = if (is.na(sha)) slug else sprintf("%s@%s", slug, substr(sha, 1L, 7L))
    url = if (is.na(sha)) sprintf("https://github.com/%s", slug) else sprintf("https://github.com/%s/tree/%s", slug, sha)
    return(list("GitHub", ref, url))
  }

  # pak records the repository it resolved from in RemoteRepos, plain installs in Repository
  src = if (!is.na(repos)) repos else repository
  if (!is.na(src)) {
    if (grepl("r-universe", src, fixed = TRUE)) {
      universe = sub("^https?://([^.]+)\\.r-universe\\.dev.*$", "\\1", src)
      return(list("r-universe", universe,
        sprintf("https://%s.r-universe.dev/%s", universe, row[["Package"]])))
    }
    if (grepl("r-multiverse|community\\.r-multiverse", src)) {
      return(list("r-multiverse", NA_character_,
        sprintf("https://community.r-multiverse.org/%s", row[["Package"]])))
    }
    if (grepl("packagemanager\\.posit|packagemanager\\.rstudio|RSPM|P3M", src, ignore.case = TRUE)) {
      return(list("PPM", NA_character_,
        sprintf("https://packagemanager.posit.co/client/#/repos/cran/packages/%s", row[["Package"]])))
    }
    if (grepl("bioconductor", src, ignore.case = TRUE)) {
      return(list("Bioconductor", NA_character_,
        sprintf("https://bioconductor.org/packages/%s", row[["Package"]])))
    }
    if (grepl("^CRAN$|cloud\\.r-project\\.org|cran\\.", src, ignore.case = TRUE)) {
      return(list("CRAN", NA_character_,
        sprintf("https://cran.r-project.org/package=%s", row[["Package"]])))
    }
  }

  if (!is.na(priority) && priority %in% c("base", "recommended")) {
    return(list(priority, NA_character_,
      sprintf("https://cran.r-project.org/package=%s", row[["Package"]])))
  }
  if (!is.na(type) && type %in% c("url", "local")) {
    return(list(type, value(row, "RemoteUrl"), value(row, "RemoteUrl")))
  }
  list("unknown", src, NA_character_)
}

# --- minimal JSON writer (no jsonlite dependency) -----------------------------

json_string = function(x) {
  if (is.na(x)) return("null")
  x = gsub("\\", "\\\\", x, fixed = TRUE)
  x = gsub("\"", "\\\"", x, fixed = TRUE)
  x = gsub("\n", "\\n", x, fixed = TRUE)
  x = gsub("\r", "\\r", x, fixed = TRUE)
  x = gsub("\t", "\\t", x, fixed = TRUE)
  paste0("\"", x, "\"")
}

json_object = function(x) {
  keys = vapply(names(x), json_string, "", USE.NAMES = FALSE)
  values = vapply(x, json_string, "", USE.NAMES = FALSE)
  paste0("{", paste0(keys, ":", values, collapse = ","), "}")
}

records = vapply(seq_len(nrow(ip)), function(i) {
  row = as.list(ip[i, ])
  o = origin(row)
  json_object(c(
    package = row[["Package"]],
    version = value(row, "Version"),
    source = o[[1L]],
    ref = o[[2L]],
    url = o[[3L]],
    priority = value(row, "Priority")))
}, "")

quarto = tryCatch(sub("^", "", system2("quarto", "--version", stdout = TRUE, stderr = FALSE)[1L]),
  error = function(e) NA_character_, warning = function(w) NA_character_)

meta = json_object(c(
  image = image,
  generated = format(Sys.time(), "%Y-%m-%dT%H:%M:%SZ", tz = "UTC"),
  r_version = R.version.string,
  platform = R.version$platform,
  quarto_version = quarto,
  commit = {x = Sys.getenv("GITHUB_SHA"); if (nzchar(x)) x else NA_character_},
  n_packages = as.character(nrow(ip))))

cat(sprintf("{\"meta\":%s,\"packages\":[%s]}\n", meta, paste0(records, collapse = ",")))
