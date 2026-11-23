# #!/bin/bash

# # 1. check whether /secrets/mysql-secret.txt exist
# # 2. if exist export and remove
# # 3. if not exist throw the error

# if [ -f /secrets/mysql-secret.txt ]; then
#     ROOT_PASSWORD=$(cat /secrets/mysql-secret.txt)
#     echo "Password accessed successfully"
# else
#     echo "cant find the password"
#     exit 1
# fi

# export MYSQL_ROOT_PASSWORD=$ROOT_PASSWORD
# rm /secrets/mysql-secret.txt

# exec /usr/local/bin/docker-entrypoint.sh mysqld



# cat > secret-reader.sh <<'EOF'
!/bin/bash
set -e

SECRET_FILE="/secrets/mysql-secret.txt"

if [ ! -f "$SECRET_FILE" ]; then
    echo "ERROR: Secret file not found"
    exit 1
fi

ROOT_PASSWORD=$(cat "$SECRET_FILE")

if [ -z "$ROOT_PASSWORD" ]; then
    echo "ERROR: MySQL password is empty"
    exit 1
fi

export MYSQL_ROOT_PASSWORD="$ROOT_PASSWORD"

echo "MySQL password loaded successfully"

exec /usr/local/bin/docker-entrypoint.sh "$@"
EOF

