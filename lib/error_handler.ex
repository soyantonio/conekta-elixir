defmodule ConektaError do
    defexception message: "default message"
end

defmodule Conekta.ErrorHandler do
  alias Conekta.ErrorResponse

  def catch_error(content) do
    {:ok, error} = Poison.decode(content.body, as: %ErrorResponse{})
    raise ConektaError, message: hd(error.details)["debug_message"]
  end

  def raise_error(content) when is_map(content) do
    error = Poison.decode!(content.body)
    raise ConektaError, message: error["error"]
  end

end
