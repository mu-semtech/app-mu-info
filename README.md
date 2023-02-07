# app-mu-info

## How to

Setting up your environment is done in three easy steps:  first you configure the running microservices and their names in `docker-compose.yml`, then you configure how requests are dispatched in `config/dispatcher.ex`, and lastly you start everything.

### Hooking things up with docker-compose

Alter the `docker-compose.yml` file so it contains all microservices you need.  The example content should be clear, but you can find more information in the [Docker Compose documentation](https://docs.docker.com/compose/).  Don't remove the `identifier` and `db` container, they are respectively the entry-point and the database of your application.  Don't forget to link the necessary microservices to the dispatcher and the database to the microservices.

### Configure the dispatcher

Next, alter the file `config/dispatcher.ex` based on the example that is there by default.  Dispatch requests to the necessary microservices based on the names you used for the microservice.

### Boot up the system

Boot your microservices-enabled system using docker-compose.

    cd /path/to/mu-project
    docker-compose up

You can shut down using `docker-compose stop` and remove everything using `docker-compose rm`.

## Reference
Please also check the docstrings and typing included in the code!

### Repo model
This is defined in [config/resources/domain.lisp](config/resources/domain.lisp) and [the Repo class](app/Repo.py). Here's a human-readable overview!
| Attribute          | Type             | Description                                        |
| ------------------ | ---------------- | ---------------------------------------------------|
|**Describe the repo**|||
| uuid (indirectly)  | `String`         | UUID for the graph name.                                   |
| title              | `String`         | Repository name.                                   |
| description        | `String`         | A small description of what the repository is for. |
| category           | `URI`            | What type of repository it is.                     |
||||
|**Link to relevant URLs**|||
| repo-url            | `String/URL`    | Repository url        |
| image-url           | `String/URL`    | Container image url   |
| homepage-url       | `String/URL`     | Homepage url          |
||||
| **Other** |||
| installed_version  | `Revision`       | The version that is installed! |

---

### Revision model
These will be given to a repo in the triplestoer, and allow to read the documentation of every release 
| Attribute          | Type             | Description       |
| ------------------ | ---------------- |-------------------|
| image-tag           | `String`        | Revision release *tag* for the image |
| image-url           | `String/URL`    | Revision release *url* for the image |
| repo-tag            | `String`        | Revision release *tag* from the repository |
| repo-url            | `String/URL`    | Revision release *url* from the repository |
| 
| readme             | `String`         | Content of the README |
| documentation?     | `String`?        | splitted up readme thing for each version (divio-docs-gen) |


Default? Master/main?

## License
This project is licensed under [the MIT License](LICENSE).
