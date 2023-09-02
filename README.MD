# Snippetbox

## From the book ["Let's Go"](https://lets-go.alexedwards.net/) by Alex Edwards

## Table of contents

- [ENV](#env)
- [HTTPS](#https)
- [RUN FROM CLI](#run-from-cli-without-env)
- [RUN IN DOCKER](#run-in-docker)

### ENV

Make sure to have a `.env` file with the following properties (see `.env.example`):

```bash
PORT=<port_number> # default 4000
DB_USERNAME=<database_user>
DB_PASS=<database_password>
DB_DATABASE=<your_database_name>
# If using Docker, add these
DB_PORT=3306
DB_IP=mysql
```

### HTTPS

To serve the app as `https`, you need to create a tls folder with certificates.
You can use go's inbuilt tls package.
On MacOS, if installed via homebrew, the location of it is:

```bash
/opt/homebrew/Cellar/go/<GO_VERSION>/libexec/src/crypto/tls
```

From within the `tls` folder, run the following command to generate
certificates for localhost:

```bash
<PATH_TO_TLS_FOLDER_ABOVE>/generate_cert.go --rsa-bits=2048 --host=localhost
```

This will generate `cert.pem` and `key.pem` files which will allow
your app to run on `https`.

### RUN FROM CLI (without env)

If you don't want to use a `.env` file, pass the required properties as cli arguments:

```bash
go run ./cmd/web -addr=PORT_NUMBER -dsn=DSN_STRING
```

where DSN_STRING is of the following format:

```go
// tcp(<DB_IP>:<DB_PORT>) is only needed if DB is not running in localhost
// ?multiStatements=true is needed for migrations
dsn := "<DB_USERNAME>:<DB_PASSWORD>@tcp(<DB_IP>:<DB_PORT>)/<DB_DATABASE>?parseTime=true&multiStatements=true"
```

To run the app, use:

```bash
go run ./cmd/web
```

To run the app in debug mode, use:

```bash
go run ./cmd/web -debug
```

To run the tests, use:

```bash
go test ./cmd/web -v
```

### RUN IN DOCKER

To build the app and run from Docker, use:

```bash
docker compose up -d
```
