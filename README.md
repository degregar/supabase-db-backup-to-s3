# PostgreSQL Backup to Supabase Storage

This is a tool that lets you backup your PostgreSQL database to Supabase Storage. The tool runs as a Docker container and can be scheduled to run at specific times using a cron service like Render.com.

## Prerequisites

- Docker
- A PostgreSQL database to backup
- A Supabase account
- S3 storage bucket
- AWS IAM user with S3 access

## Installation

1. Clone this repository
2. Build the Docker image: `docker build -t backup-supabase-to-s3 .`

## Configuration

The following environment variables are required:

- `DATABASE_URL`: The URL of the PostgreSQL database to backup
- `USE_PGDUMPALL`: Set to `true` to use `pg_dumpall` instead of `pg_dump` (default: `false`)
- `AWS_S3_BUCKET_NAME`: The name of the S3 bucket to store the backups in
- `AWS_ACCESS_KEY_ID`: The access key for the AWS IAM user
- `AWS_SECRET_ACCESS_KEY`: The secret access key for the AWS IAM user
- `AWS_DEFAULT_REGION`: The default region for the S3 bucket

You can set these environment variables by copying `.env.example` to a file called `.env` in the root directory of this project.

Alternatively, you can set these environment variables using the method recommended by your hosting provider.

## Usage

To run the backup process manually, you can use the following command:

```
docker run --rm --env-file .env backup-supabase-to-s3
```


To schedule the backup process to run at specific times, you can use a cron service like Render.com. In Render.com, create a new cron job and set the command to:

```
docker run --rm --env-file /path/to/your/.env backup-supabase-to-s3
```

Set the schedule to the desired frequency (e.g. daily, weekly) and the timezone to your local timezone.

For example, a cron schedule that would execute 6 minutes past every 12 hours would be

```cron
6 */12 * * *
```

## License

This project is licensed under the [MIT License](LICENSE).
