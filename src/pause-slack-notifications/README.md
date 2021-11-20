# Pause Slack Notifications

Pause or resume notifications on [Slack](https://slack.com/).

## Download

Download from the [latest release](https://github.com/mirka/keyboard-maestro-plugin-actions/releases/latest).

## How to use

### Get a Slack OAuth access token

You will first need a Slack OAuth access token with the `dnd:write` scope.

1. Go to your [Apps page](https://api.slack.com/apps/) and create a new app for your Slack workspace.
2. Go to OAuth & Permissions ▸ Scopes ▸ User Token Scopes.
3. Click the “Add an OAuth Scope” button and add the `dnd:write` scope.
4. Scroll up to the “OAuth Tokens & Redirect URLs” section and click the “Install App to Workspace” button. Complete the install as directed.
5. You should now be able to copy your OAuth access token.

### Parameters

- **OAuth token**: Paste your OAuth token here.
- **Notifications**: Whether to pause or resume notifications.
- **Pause duration in minutes**: The number of minutes to pause notifications. This value is required when sending a pause request, but will be ignored for resume requests.

The action will return the JSON response from the Slack server. If you save this to a variable, for example called `result`, you can easily parse this by using text tokens like `%JSONValue%result.ok%`.
