describe 'A Bureau Instance' do
  before do
    @obj = nil
    @structure = [
      {
        title: 'Choose Your Door',
        drawers:
        [
          {title: 'Door #1', controller: UIViewController.alloc.init},
          {title: 'Door #1', controller: UIViewController},
          {title: 'Door #2', target:@obj, action: :speak},
        ],
      },
    ]
  end

  it 'errors if structure is not an array' do
    @structure = :not_an_array
    exception = lambda{
      Bureau::Bureau.new(structure: @structure)
    }.should.raise(Bureau::StructureError)
    exception.message.should == "structure must be an array"
  end

  it 'does not error if structure is an empty array' do
    @structure = []
    exception = lambda{
      Bureau::Bureau.new(structure: @structure)
    }.should.not.raise Bacon::Error
  end

  it 'errors if structure has a non-hash element' do
    not_a_hash = :not_a_hash
    @structure[1] = not_a_hash
    exception = lambda{
      Bureau::Bureau.new(structure: @structure)
    }.should.raise(Bureau::StructureError)
    exception.message.should == \
      "structures can only contain hashes (one for each table section) (#{not_a_hash}.class != Hash)"
  end

  it 'errors if section[:drawers] is present and not an array' do
    not_an_array = :not_an_array
    @structure.first[:drawers] = not_an_array
    exception = lambda{
      Bureau::Bureau.new(structure: @structure)
    }.should.raise(Bureau::StructureError)
    exception.message.should == \
      "hashes inside structure must define :drawers as an array (each element representing a menu row) if it is present (#{not_an_array}.class != Array)"
  end

  it 'does not error if section[:drawers] is an array' do
    @structure.first[:drawers] = []
    exception = lambda{
      Bureau::Bureau.new(structure: @structure)
    }.should.not.raise Bacon::Error
  end

  it "errors if a drawer is not a hash" do
    not_a_hash = :not_a_hash
    @structure.first[:drawers][0] = not_a_hash
    exception = lambda{
      Bureau::Bureau.new(structure: @structure)
    }.should.raise(Bureau::StructureError)
    exception.message.should == "all elements of section[:drawers] must be a hash (each element representing a menu row) (#{not_a_hash}.class != Hash)"
  end

  it 'does not error if :drawers is empty' do
    @structure.first[:drawers] = []
    exception = lambda{
      Bureau::Bureau.new(structure: @structure)
    }.should.not.raise Bacon::Error
  end

  it 'does not error if every element of section[:drawers] is a hash' do
    exception = lambda{
      Bureau::Bureau.new(structure: @structure)
    }.should.not.raise Bacon::Error
  end
end
