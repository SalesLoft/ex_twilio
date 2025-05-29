defmodule ExTwilio.UserDefinedMessage do
  @moduledoc """
  Represents a UserDefinedMessage resource in the Twilio API.

  A UserDefinedMessage Resource represents a user-defined message that is sent to a Voice SDK end user during an active Call.

  A UserDefinedMessage Resource can only be created during an active Call associated with the Voice SDK.

  Read more about the Voice SDK messaging feature on the [Voice SDK Call Message Events Page](https://www.twilio.com/docs/voice/sdk/ios/voice-client-sdk-call-message-events).

  - [Twilio docs](https://www.twilio.com/docs/voice/api/userdefinedmessage-resource)

  ## Examples

  Since UserDefinedMessages belong to a Call in Twilio's API, you must pass a Call SID
  to the create function in this module.

      ExTwilio.UserDefinedMessage.create([content: "{\"example_key\": \"Hello from the server side!\"}"], call: "call_sid")

  You can also specify an idempotency key for safe retries:

      ExTwilio.UserDefinedMessage.create([
        content: "{\"message\": \"Hello!\"}",
        idempotency_key: "unique-key-123"
      ], call: "call_sid")

  ## Parameters

  ### Required
  - `content` - The User Defined Message in the form of URL-encoded JSON string

  ### Optional
  - `idempotency_key` - A unique string value to identify API call for safe retries

  ## Response Properties

  - `sid` - The SID that uniquely identifies this User Defined Message (Pattern: ^KX[0-9a-fA-F]{32}$)
  - `account_sid` - The SID of the Account that created User Defined Message
  - `call_sid` - The SID of the Call the User Defined Message is associated with
  - `date_created` - The date that this User Defined Message was created, given in RFC 2822 format

  ## Important Notes

  - UserDefinedMessages can only be created during an active Call associated with the Voice SDK
  - Use the parent Call SID to send a message to the parent Call leg
  - Use the child Call SID to send a message to the child Call leg
  - The content must be a stringified JSON object
  """

  defstruct sid: nil,
            account_sid: nil,
            call_sid: nil,
            date_created: nil

  use ExTwilio.Resource, import: [:create]

  def parents, do: [:account, :call]
end
