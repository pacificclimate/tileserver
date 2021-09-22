# tileserver

PCIC's custom tileserver image which is used to serve maps tiles to our applications. 

## Configuration

The tileserver is built using the Apache Webserver (from repo) and [mod_tile](https://github.com/openstreetmap/mod_tile). The tiles have been pre-rendered and are stored on shared storage which can be mounted into the container. We have not enabled renderd in the container since we want to serve tiles, not render them at this point. 

Some of the configuration items you'll need to provide are: 
### Apache 
Provide configuration files for Apache to: 
  * Load the `mod_tiles` module
  * Serve the tiles
  * Listen on the correct port
  * Setup logging

### Mapnik 
Mapnik files are not included in the image or with docker-compose since they're not needed to serve pre-rendered tiles, though they are referenced in the docker-compose (commented out). 

### Renderd
The renderd configuration is used by `mod_tiles` to determine where to serve tiles from. 

### Tilestore
The tilestore directory provides the tiles that will be served

### Run script
A basic run.sh script is included in the image, but a customized one may be required for logging or other settings. 
* The `run.sh` script links the `access.log` and `error.log` files to `stdout` and `stderr` prior to starting apache

### View Tiles
Some sample files can be included in the webroot that allow you to view tiles for diagnostic purposes. 

## Releasing

Creating a versioned release involves:

1. Summarize the changes from the last release in `NEWS.md`
2. Commit these changes, then tag the release:

  ```bash
git add NEWS.md
git commit -m"Bump to version x.x.x_xx"
git tag -a -m"x.x.x_xx" x.x.x_xx
git push --follow-tags
  ```
