# RECORDER

:wrench: This is a [drone ci plugin](https://github.com/drone) to be used in our CI pipeline.

It allows to record vnc sessions (i.e. from  [Docker Selenium Containers](https://hub.docker.com/r/selenium/)) for later review

## Usage


**As a service**
```
pipeline:
  test-step
    image: myimage
    commands:
      - run_test.sh

services:
  recorder:
    image: owncloudci/recorder
    password:secret
    hostname:selenium

  selenium:
    image: selenium/standalone-chrome-debug:latest
```

**As pipeline step**

```
pipeline:
  recorder:
    image: owncloudci/vnc-recorder
    detach: true
    environment:
      - PLUGIN_PASSWORD=secret
      - PLUGIN_HOSTNAME=selenium

  test-step
    image: myimage
    commands:
      - run_test.sh

services:
  selenium:
    image: selenium/standalone-chrome-debug:latest
```



### Full list of variables

```
PLUGIN_HOSTNAME
PLUGIN_PASSWORD
PLUGIN_PORT
PLUGIN_FILENAME
PLUGIN_OUTPUT_PATH
PLUGIN_PASSWORD_FILE
```

## Issues, Feedback and Ideas

Open an [Issue](https://github.com/owncloud-ci/recorder/issues)


## Contributing

Fork -> Patch -> Push -> Pull Request


## Authors

* [Patrick Jahns](https://github.com/patrickjahns)


## License

MIT


## Copyright

```
Copyright (c) 2018 Patrick Jahns <pjahns@owncloud.com>
```
