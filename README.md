# App-mu-info

A service for storing a bunch of repo information into JSON:API.
Including (but not limited to):
- Repositories with
    - Title
    - Description
    - Self-definable categories
- Revisions with
    - The git tag & link to the relevant repository url
    - The image tag & link to relevant image url
    - README.md
    - The README.md parsed into divio docs structure

This project includes [repo-harvester](https://github.com/mu-semtech/repo-harvester) to be fed data. An example of how this can be implemented is the documentation site at [semantic.works/docs](https://semantic.works/docs).


## How to
### Start service
```bash
git clone https://github.com/mu-semtech/app-mu-info.git
cd app-mu-info/
docker-compose up --detach
```

### Initialize data
```bash
docker-compose exec harvester curl localhost:80/init
```
*Note: this can be called externally if the right ports are opened for the harvester and/or identifier service*

### Update data
```bash
docker-compose exec harvester curl localhost:80/update
```
*Note: this can be called externally if the right ports are opened for the harvester and/or identifier service*

### Development mode with repo-harvester
```yml
# app-mu-info/docker-compose.override.yml
version: '3.4'

services:
  harvester:
    image: repo-harvester
    volumes:
      - ../repo-harvester/:/app
      - ../cache/:/usr/src/app/cache/
    ports:
      - "5000:80"
```

*Note: the following is run from within the cloned app-mu-info/ directory
```bash
cd ..
git clone https://github.com/mu-semtech/repo-harvester.git
cd app-mu-info/
docker-compose -f docker-compose.yml -f docker-compose.dev.yml -f docker-compose.override.yml up
```

## Reference

### Repo model
This is defined in [config/resources/domain.lisp](config/resources/domain.lisp) and [the Repo class of repo-harvester](https://github.com/mu-semtech/repo-harvester/blob/master/Repo.py). Here's a human-readable overview!

| Attribute          | Type             | Description                                        |
| ------------------ | ---------------- | ---------------------------------------------------|
|**Describe the repo**|||
| uuid (implicit)    | `String`         | UUID for the graph name.                                   |
| title              | `String`         | Repository name.                                   |
| description        | `String`         | A small description of what the repository is for. |
| category           | `URI`            | What type of repository it is.                     |

---

### Revision model
These will be given to a repo in the triplestore, and allow to read the documentation of every release 
| Attribute          | Type             | Description       |
| ------------------ | ---------------- | ----------------- |
| image-tag           | `String`        | Revision release *tag* for the image |
| image-url           | `String/URL`    | Revision release *url* for the image |
| repo-tag            | `String`        | Revision release *tag* from the repository |
| repo-url            | `String/URL`    | Revision release *url* from the repository |
| 
| readme             | `String`         | Content of the README |
| tutorials          | `String`         | Tutorials extracted & parsed from the README |
| how-to-guides      | `String`         | How To guides extracted & parsed from the README |
| explanation        | `String`         | Explanation(s) extracted & parsed from the README |
| reference          | `String`         | Reference(s) extracted & parsed from the README |


## Discussion

### Possible expansion
It would be interesting to have the following data also available:

| Attribute          | Type             | Description       |
| ------------------ | ---------------- | ----------------- |
| homepage-url        | `String/URL`     | Homepage url          |
| installed_version  |  `Revision`       | The version that is installed on the local machine |

## License
This project is licensed under [the MIT License](LICENSE).
