FROM makocchi/alpine-git-curl-jq:latest

LABEL "com.github.actions.name"="Mirror to GitLab and run GitLab CI"
LABEL "com.github.actions.description"="Automate mirroring of git commits to GitLab, trigger GitLab CI and post results back to GitHub"
LABEL "com.github.actions.icon"="git-commit"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="https://github.com/SvanBoxel/gitlab-mirror-and-ci-action"
LABEL "homepage"="https://github.com/SvanBoxel/gitlab-mirror-and-ci-action"
LABEL "maintainer"="Sebass van Boxel <hello@svboxel.com>"


COPY entrypoint.sh /entrypoint.sh
COPY cred-helper.sh /cred-helper.sh
ENTRYPOINT ["/entrypoint.sh"]
