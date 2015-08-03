describe ValueObject do
  class SomeValue
    include ValueObject.new(:key, :value)
    attr_accessor :key, :value
  end

  it 'includes Adamantium and Lift into classes that include it' do
    expect(SomeValue.ancestors).to include Adamantium
    expect(SomeValue.ancestors).to include Lift
  end

  describe '#==' do
    it 'is equal to other value objects with the same value' do
      value1 = SomeValue.new(key: 'k', value: 'v')
      value2 = SomeValue.new(key: 'k', value: 'v')
      expect(value1).to eq value2
    end

    it 'is not equal to other value objects with differing values' do
      value1 = SomeValue.new(key: 'k', value: 'v')
      value2 = SomeValue.new(key: 'k', value: 'eh?')
      expect(value1).not_to eq value2
    end
  end

  describe '#inspect' do
    it 'includes the class name' do
      expect(SomeValue.new.inspect).to start_with '#<SomeValue'
    end

    it 'includes each attribute and its value' do
      val = SomeValue.new key: 'lock'
      inspect_string = val.inspect
      expect(inspect_string).to include 'key'
      expect(inspect_string).to include 'lock'
      expect(inspect_string).to include 'value'
      expect(inspect_string).to include 'nil'
    end
  end
end
