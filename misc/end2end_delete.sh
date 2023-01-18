sleep_counter=0.5
login_credential="admin:admin"

# Delete service proxy
curl --location -k --request DELETE 'https://127.0.0.1/api/acm/v1/services/workspaces/my_proxy_workspace/proxies/httpbin-api?hostname=api.gwcluster.com&version=1.0' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
-u $login_credential \
--data-raw ''

sleep $sleep_counter
sleep $sleep_counter
sleep $sleep_counter

# Delete API Docs
curl --location -k --request DELETE 'https://127.0.0.1/api/acm/v1/services/workspaces/my_proxy_workspace/api-docs/httpbin-1-0-oas3' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
-u $login_credential \
--data-raw ''

sleep $sleep_counter

# Delete Service Workspace
curl --location -k --request DELETE 'https://127.0.0.1/api/acm/v1/services/workspaces/my_proxy_workspace' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
-u $login_credential \
--data-raw ''

sleep $sleep_counter

# Delete Infra Environment
curl --location -k --request DELETE 'https://127.0.0.1/api/acm/v1/infrastructure/workspaces/my_infra_workspace/environments/nonprod' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
-u $login_credential \
--data-raw ''

sleep $sleep_counter
sleep $sleep_counter
sleep $sleep_counter

# Delete Infra workspace
curl --location -k --request DELETE 'https://127.0.0.1/api/acm/v1/infrastructure/workspaces/my_infra_workspace' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
-u $login_credential \
--data-raw ''