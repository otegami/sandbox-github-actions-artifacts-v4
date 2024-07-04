# sandbox-github-actions-artifacts-v4

```console
$ ARTIFACT_URL="https://api.github.com/repos/:owner/sandbox-github-actions-artifacts-v4/actions/artifacts/:artifact_id/zip" \
  GITHUB_ACCESS_TOKEN=xxxx \
  ruby download_artifact.rb
```

## Note

We dont't need `/zip` but we want to make it redirect so we added it here.
ref: https://docs.github.com/en/rest/actions/artifacts?apiVersion=2022-11-28#get-an-artifact
