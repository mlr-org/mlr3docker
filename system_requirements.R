library(pak)

## mlr3book

pkgs_book = c(
  "bestNormalize",
  "counterfactuals",
  "CVXR",
  "DALEX",
  "DALEXtra",
  "dbplyr",
  "dbscan",
  "DiceKriging",
  "downlit",
  "duckdb",
  "fairml",
  "FSelectorRcpp",
  "gbm",
  "GenSA",
  "GGally",
  "ggdendro",
  "ggExtra",
  "ggfortify",
  "ggtext",
  "igraph",
  "iml",
  "kknn",
  "knitr",
  "lhs",
  "lightgbm",
  "linprog",
  "magick",
  "maps",
  "nloptr",
  "nycflights13",
  "partykit",
  "pendensity",
  "PMCMRplus",
  "precrec",
  "qgam",
  "qs",
  "quadprog",
  "randomForestSRC",
  "ranger",
  "remotes",
  "rgenoud",
  "rmarkdown",
  "RSQLite",
  "survivalsvm",
  "xgboost",
  "xml2"
)

# query system dependencies for Ubuntu 22.04
sysreq_book = pak::pkg_sysreqs(pkgs_book, sysreqs_platform = "ubuntu-22.04", dependencies = NA)
sysreq_book = unlist(sysreq_book$packages$system_packages)

# add repo for mlr3proba
pak::repo_add(
  mlr3universe = "https://mlr-org.r-universe.dev"
)

# add mlr3verse dependencies including suggested packages
sysreq_mlr3verse_all = pak::pkg_sysreqs("mlr3verse", sysreqs_platform = "ubuntu-22.04", dependencies = TRUE)
sysreq_mlr3verse_all = unlist(sysreq_mlr3verse_all$packages$system_packages)
sysreq_book = union(sysreq_book, sysreq_mlr3verse_all)


# print
cat(paste(sort(sysreq_book), "\\"), sep = "\n")


## mlr3full
pak::repo_add(
  mlr3universe = "https://mlr-org.r-universe.dev",
  multiverse = "https://community.r-multiverse.org"
)

sysreq_mlr3db = pak::pkg_sysreqs("mlr3db", sysreqs_platform = "ubuntu-22.04", dependencies = TRUE)
sysreq_mlr3db = unlist(sysreq_mlr3db$packages$system_packages)

# pak::pkg_sysreqs never finishes when mlr3verse and mlr3db are included
pkg_full = c(
  #"mlr3verse",
  "bbotk",
  #"mlr3db",
  "mlr3fairness",
  "mlr3hyperband",
  "mlr3oml",
  "mlr3learners",
  "remotes",
  "BART",
  "mlr3extralearners"
)

sysreq_full = pak::pkg_sysreqs(pkg_full, sysreqs_platform = "ubuntu-22.04", dependencies = TRUE)
sysreq_full = unlist(sysreq_full$packages$system_packages)
sysreq_full = union(sysreq_full, sysreq_mlr3db)
sysreq_full = union(sysreq_full, sysreq_mlr3verse_all)

cat(paste(sort(sysreq_full), "\\"), sep = "\n")

