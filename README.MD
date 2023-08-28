# Snippetbox

## From the book ["Let's Go"](https://lets-go.alexedwards.net/) by Alex Edwards

Make sure to have a `.env` file with the following properties:

```bash
PORT=<port_number> # default 4000
DB_USERNAME=<database_user>
DB_PASS=<database_password>
DB_DATABASE=<your_database_name>
```

If you don't want to use a `.env` file, pass the required properties as cli arguments:

```bash
go run ./cmd/web -addr=PORT_NUMBER -dsn=DSN_STRING
```

where DSN_STRING is of the following format:

```go
dsn := "<DB_USERNAME>:<DB_PASSWORD>@/<DB_DATABASE>?parseTime=true"
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
