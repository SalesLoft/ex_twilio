# UserDefinedMessage Usage Examples

This document provides examples for using the `ExTwilio.UserDefinedMessage` resource to send messages to Voice SDK end users during active calls.

## Basic Usage

Send a simple message to a call:

```elixir
# Create a user-defined message for an active call
{:ok, message} = ExTwilio.UserDefinedMessage.create(
  [content: "{\"example_key\": \"Hello from the server side!\"}"],
  call: "CAxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
)
```

## With Account SID

If you need to specify a specific account (useful for subaccounts):

```elixir
{:ok, message} = ExTwilio.UserDefinedMessage.create(
  [content: "{\"message\": \"Hello from subaccount!\"}"],
  call: "CAxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
  account: "ACyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy"
)
```

## With Idempotency Key

For safe retries, you can include an idempotency key:

```elixir
{:ok, message} = ExTwilio.UserDefinedMessage.create(
  [
    content: "{\"notification\": \"Call status update\"}",
    idempotency_key: "unique-key-12345"
  ],
  call: "CAxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
)
```

## Complex Message Content

You can send structured JSON data:

```elixir
content_data = %{
  "action" => "show_notification",
  "title" => "Call Update",
  "message" => "Your call is being transferred",
  "metadata" => %{
    "transfer_reason" => "escalation",
    "timestamp" => DateTime.utc_now() |> DateTime.to_iso8601()
  }
}

{:ok, message} = ExTwilio.UserDefinedMessage.create(
  [content: Jason.encode!(content_data)],
  call: "CAxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
)
```

## Error Handling

Handle potential errors:

```elixir
case ExTwilio.UserDefinedMessage.create(
  [content: "{\"message\": \"Hello!\"}"],
  call: "CAxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
) do
  {:ok, message} ->
    IO.puts("Message sent successfully: #{message.sid}")

  {:error, error, status_code} ->
    IO.puts("Failed to send message: #{inspect(error)} (Status: #{status_code})")
end
```

## Response Structure

A successful response will return a struct with the following fields:

- `sid` - The unique identifier for the UserDefinedMessage
- `account_sid` - The SID of the Account that created the message
- `call_sid` - The SID of the Call the message is associated with
- `date_created` - The date the message was created

## Important Notes

1. **Active Call Required**: UserDefinedMessages can only be created during an active Call associated with the Voice SDK.

2. **JSON Content**: The `content` parameter must be a URL-encoded JSON string.

3. **Call Legs**: Use the appropriate Call SID:
   - Use the parent Call SID to send a message to the parent Call leg
   - Use the child Call SID to send a message to the child Call leg

4. **Voice SDK Integration**: The receiving end must be using the Voice SDK to receive and process these messages.

For more information, see the [Twilio Voice SDK Call Message Events documentation](https://www.twilio.com/docs/voice/api/userdefinedmessage-resource).
