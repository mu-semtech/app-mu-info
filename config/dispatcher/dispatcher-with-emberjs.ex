defmodule Dispatcher do
  use Matcher

  define_accept_types [
    json: [ "application/json", "application/vnd.api+json" ],
    html: [ "text/html", "application/xhtml+html" ],
    any: [ "*/*" ]
  ]

  @html %{ accept: %{ html: true } }
  @json %{ accept: %{ json: true } }
  @any %{ accept: %{ any: true } }


  # In order to forward the 'themes' resource to the
  # resource service, use the following forward rule.
  #
  # docker-compose stop; docker-compose rm; docker-compose up
  # after altering this file.
  #
  # match "/themes/*path" do
  #   Proxy.forward conn, path, "http://resource/themes/"
  # end

  get "/repos/*path", _ do
    forward conn, path, "http://resource/repos/"
  end

  get "/repo-revisions/*path", _ do
    forward conn, path, "http://resource/repo-revisions/"
  end

  match "/harvester/*path", _ do
    forward conn, path, "http://harvester:80/"
  end

  match "/conductor/*path", _ do
    forward conn, path, "http://db:8890/conductor/"
  end

  match "/sparql/*path", _ do
    forward conn, path, "http://db:8890/sparql/"
  end

  match "/assets/*path", @any do
    forward conn, path, "http://frontend/assets/"
  end

  match "/*_path", @html do
    # *_path allows a path to be supplied, but will not yield
    # an error that we don't use the path variable.
    forward conn, [], "http://frontend/index.html"
  end

  match "/*_", %{ last_call: true, accept: %{ json: true } } do
    send_resp( conn, 404, "{ \"error\": { \"code\": 404, \"message\": \"Route not found.  See config/dispatcher.ex\" } }" )
  end


  #match "/*", _ do
  #  send_resp( conn, 404, "Route not found.  See config/dispatcher.ex" )
  #end

end
