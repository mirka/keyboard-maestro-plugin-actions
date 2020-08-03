# Post to Slack

![Slack Plugin for Keyboard Maestro](https://jaguchi.com/wp-content/uploads/2015/03/016-featured-image-868x454.jpg)

Post messages to [Slack](https://slack.com/) from [Keyboard Maestro](https://www.keyboardmaestro.com/).

It makes it super easy to integrate automated Slack posts in your workflows, or even set up an array of bots with different names and icons.

## Download

Download from the [latest release](https://github.com/mirka/keyboard-maestro-plugin-actions/releases/latest).

## How to use

Make sure you have an [Incoming Webhook integration](https://api.slack.com/incoming-webhooks) set up. If you don’t, [make one](https://my.slack.com/services/new/incoming-webhook/). (The settings here don’t really matter because the target channel, username, and icon can all be overridden from the Keyboard Maestro action.)

-   **Webhook URL**: Paste the URL (https://hooks.slack.com/services/…) here
-   **Channel or DM**: Choose a #channelname to post to, or a @username for direct messages (Tip: For testing purposes, put your own username here so nobody else will see the posts!)
-   **Username**: A name for your bot
-   **Icon Type**: Icons can either be an Emoji or pulled from a URL
-   **Icon**: If you chose Emoji in the previous field, put an [emoji shortcut name](https://slack.zendesk.com/hc/en-us/articles/202931348-Using-emoji-and-emoticons) here. Otherwise specify an image URL.

## Changelog

### 2015/03/24

-   Escape double quotes in Username/Message fields
-   Preserve line breaks in Message field
