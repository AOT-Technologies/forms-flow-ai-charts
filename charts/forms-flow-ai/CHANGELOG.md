# Changelog
## 8.2.0 (2025-06-26)
### Added
  Support for custom environment variables in configmap template.

  Added env variables

    USER_NAME_DISPLAY_CLAIM 
    ENABLE_COMPACT_FORM_VIEW
    FORMIO_DB_NAME
    CHROME_DRIVER_TIMEOUT
### Changed
  Updated mongodb version image tag into `8.0.10-debian-12-r2`
  Updated postgresql version image tag into `17.5.0-debian-12-r10`
### Fixed
  Fixed missing environment in `README.md`.