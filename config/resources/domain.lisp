(in-package :mu-cl-resources)

(define-resource microservice ()
  :class (s-prefix "ext:Microservice")
  :properties `((:title :string ,(s-prefix "dct:title"))
                (:description :string ,(s-prefix "dct:description"))
                (:is-core :boolean ,(s-prefix "ext:isCoreMicroservice"))
                (:git-repository :url ,(s-prefix "ext:gitRepository"))
                (:repository :url ,(s-prefix "ext:repository"))
                (:creation-snippet :string ,(s-prefix "ext:creationSnippet"))
                (:development-snippet :string ,(s-prefix "ext:developmentSnippet"))
                (:compose-snippet :string ,(s-prefix "ext:composeSnippet"))
                (:installation-script :string ,(s-prefix "ext:installationScript")))
  :has-many `((revision :via ,(s-prefix "ext:hasRevision")
                        :as "revisions")
              (command :via ,(s-prefix "ext:hasCommand")
                       :as "commands"))
  :features '(no-pagination-defaults)
  :resource-base (s-url "http://info.mu.semte.ch/microservices/")
  :on-path "microservices")

(define-resource revision ()
  :class (s-prefix "ext:MicroserviceRevision")
  :properties `((:image :string ,(s-prefix "ext:microserviceRevision"))
                (:version :string ,(s-prefix "ext:microserviceVersion")))
  :has-one `((microservice :via ,(s-prefix "ext:hasRevision")
                           :inverse t
                           :as "microservice"))
  :features '(no-pagination-defaults)
  :resource-base (s-url "http://info.mu.semte.ch/microservice-revisions/")
  :on-path "microservice-revisions")

(define-resource command ()
  :class (s-prefix "ext:MicroserviceCommand")
  :properties `((:title :string ,(s-prefix "ext:commandTitle"))
                (:shell-command :string ,(s-prefix "ext:shellCommand"))
                (:description :string ,(s-prefix "dct:description")))
  :has-one `((microservice :via ,(s-prefix "ext:hasCommand")
                           :inverse t
                           :as "microservice"))
  :features '(no-pagination-defaults)
  :resource-base (s-url "http://info.mu.semte.ch/microservice-commands/")
  :on-path "microservice-commands")
