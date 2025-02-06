#!/usr/bin/env sh
# Loop through all .template files in /etc/templates/
for template in ./templates/*.template; do
    # Extract filename without the .template extension
    output_file="/etc/nginx/$(basename "$template" .template)"

    # Perform envsubst and write to the output file
    envsubst "$(printf '${%s} ' $(env | cut -d= -f1))" <"$template" >"$output_file"

    echo "Processed: $template -> $output_file"
done
exec "$@"
