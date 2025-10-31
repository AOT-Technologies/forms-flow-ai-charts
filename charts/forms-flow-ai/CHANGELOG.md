# Changelog
## 8.3.0 (2025-10-16)
### Added
  Support for custom environment variables in configmap template.

  Added env variables

    USER_NAME_DISPLAY_CLAIM 
    ENABLE_COMPACT_FORM_VIEW
    FORMIO_DB_NAME
    CHROME_DRIVER_TIMEOUT
    CONFIGURE_LOGS

### Changed

  Updated container image sources for `PostgreSQL`, `MongoDB`, and `Keycloak` to use the `bitnamilegacy` registry instead of `bitnami`.
  This change was required because `Bitnami removed these images from the main registry`, and the `bitnamilegacy` registry is being used `temporarily` until the images are restored or migrated.
  
  Updated mongodb version image tag into `8.0.10-debian-12-r2`
  Updated postgresql version image tag into `17.5.0-debian-12-r10`
