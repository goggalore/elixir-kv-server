defmodule KV.Bucket do
  use Agent, restart: :temporary

  @doc """
    Starts a new bucket.
  """
  def start_link(_options) do
    Agent.start_link(fn -> %{} end)
  end

  @doc """
    Puts a key and its value into bucket
  """
  def put(bucket, key, value) do
    # Here is the client code
    Agent.update(bucket, fn state ->
      # Here is the server code
      Map.put(state, key, value)
    end)
  end

  @doc """
    Gets a value with the provided key from a bucket
  """
  def get(bucket, key) do
    Agent.get(bucket, &Map.get(&1, key))
  end

  @doc """
    Deletes a key and its value from a bucket
  """
  def delete(bucket, key) do
    Agent.get_and_update(bucket, &Map.pop(&1, key))
  end
end
