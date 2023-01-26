# Mirror to GitLab and trigger GitLab CI

A GitHub Action that mirrors all commits to GitLab, triggers GitLab CI, and returns the results back to GitHub. 

This action uses active polling to determine whether the GitLab pipeline is finished. This means our GitHub Action will run for the same amount of time as it takes for GitLab CI to finish the pipeline. 

## Example workflow

This is an example of a pipeline that uses this action:

```workflow
name: Mirror and run GitLab CI

on: [push]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v1
    - name: Mirror + trigger CI
      uses: SvanBoxel/gitlab-mirror-and-ci-action@master
      with:
        args: "https://gitlab.com/<namespace>/<repository>"
      env:
        FOLLOW_TAGS: "false"
        FORCE_PUSH: "false"
        GITLAB_HOSTNAME: "gitlab.com"
        GITLAB_USERNAME: "svboxel"
        GITLAB_PASSWORD: ${{ secrets.GITLAB_PASSWORD }} // Generate here: https://gitlab.com/profile/personal_access_tokens
        GITLAB_PROJECT_ID: "<GitLab project ID>" // https://gitlab.com/<namespace>/<repository>/edit
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }} // https://docs.github.com/en/actions/reference/authentication-in-a-workflow#about-the-github_token-secret
```

Be sure to define the `GITLAB_PASSWORD` secret in `https://github.com/<namespace>/<repository>/settings/secrets`  
Before setup a token to use as `GITLAB_PASSWORD` here https://gitlab.com/profile/personal_access_tokens  
The token must have `read_api`, `read_repository` & `write_repository` permissions in GitLab.  
For granular permissions create seperate users and tokens in GitLab with restricted access.  

If you're rewriting history in the primary repo (e.g by using `git rebase`), you'll need to force push. Set the `FORCE_PUSH` environment variable to `true` to enable this. This will overwrite history in the mirror as well, so be **careful with this** (just like any time you're using `git push --force`).

If you want to mirror repository tags too, you can define `FOLLOW_TAGS` environment variable to `true`.
