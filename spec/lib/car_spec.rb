require "car"

describe Car do
  let(:engine) { double("Engine") }
  let(:car)    { Car.new engine }

  it "accelerates the car" do
    expect(engine).to receive(:accelerate)
    car.move
  end

end
