defmodule BasicNn.Neuron do
  def create do
    weights = [:random.uniform()-0.5,:random.uniform()-0.5,:random.uniform()-0.5]
    register(spawn(BasicNn.Neuron,:loop,[weights]),:neuron)
  end

  def loop(weights) do
    receive do
      {from, input} ->
        IO.puts "**** Processing **** 
        Input: #{inspect input} 
        Weights: #{inspect weights}"
        dot_product = dot(input, weights, 0)
        output = [:math.tanh(dot_product)]
        from.send {:result,output}
        loop(weights)
    end
  end


  defp dot([i|input],[w,weights],acc), do: dot(input,weights,i*w+acc)
  defp dot([],[bias],acc), do: acc + bias

end

