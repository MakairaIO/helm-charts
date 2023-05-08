# copy-database

This chart provides a Job to copy a database from one MySQL/MariaDB instance to another.

## Configuration example
```yaml
copy-database:
  source:
    host: "source.example.com"
    user: "source_user"
    password: "source_password"
    database: "source_database"
    ssl: # If you use an encrypted connection, add these settings.
      serverCA: |-
        Content of the server CA certificate. It is extremely important that this is encrypted.
      clientCert: |-
        Content of the client certificate. It is extremely important that this is encrypted.
      clientKey: |-
        Content of the client key. It is extremely important that this is encrypted.

  destination:
    host: "destination.example.com"
    user: "destination_user"
    password: "destination_password"
    database: "destination_database"
    ssl:
      serverCA: |-
        Content of the server CA certificate. It is extremely important that this is encrypted.
      clientCert: |-
        Content of the client certificate. It is extremely important that this is encrypted.
      clientKey: |-
        Content of the client key. It is extremely important that this is encrypted.
```
