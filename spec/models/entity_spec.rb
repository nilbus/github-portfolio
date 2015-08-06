describe Entity do
  class SomeEntity
    include Entity.new(:id)
    attr_accessor :id, :value
  end

  it 'includes Lift into classes that include it' do
    expect(SomeEntity.ancestors).to include Lift
  end

  describe '#==' do
    it 'is equal to other entities with the same identifier' do
      entity1 = SomeEntity.new(id: '1', value: 'one value')
      entity2 = SomeEntity.new(id: '1', value: 'another value')
      expect(entity1).to eq entity2
    end

    it 'is not equal to other entities with differing identifiers' do
      entity1 = SomeEntity.new(id: '1', value: 'same value')
      entity2 = SomeEntity.new(id: 'not 1', value: 'same value')
      expect(entity1).not_to eq entity2
    end
  end

  describe '#inspect' do
    it 'includes the class name' do
      expect(SomeEntity.new.inspect).to start_with '#<SomeEntity'
    end

    it 'includes each attribute and its value' do
      entity = SomeEntity.new id: 'lock'
      entity.value = 'secured'
      inspect_string = entity.inspect
      expect(inspect_string).to include 'id'
      expect(inspect_string).to include 'lock'
      expect(inspect_string).to include 'value'
      expect(inspect_string).to include 'secured'
    end
  end
end
