describe 'A Bureau Instance Validating its Structure' do
  before do
    @controller = UIViewController.alloc.init
    @structure = [
      {
        title: 'Choose Your Door',
        drawers:
        [
          {title: 'Door #1', controller: @controller},
          {title: 'Door #1', controller: UIViewController},
          {title: 'Door #2', target: @controller, action: :speak},
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

  it 'errors if a section is not a hash' do
    not_a_hash = :not_a_hash
    @structure[1] = not_a_hash
    exception = lambda{
      Bureau::Bureau.new(structure: @structure)
    }.should.raise(Bureau::StructureError)
    exception.message.should == \
      "structures can only contain hashes (one for each table section) (#{not_a_hash}.class != Hash)"
  end

  it 'errors if a drawer list is not an array' do
    not_an_array = :not_an_array
    @structure.first[:drawers] = not_an_array
    exception = lambda{
      Bureau::Bureau.new(structure: @structure)
    }.should.raise(Bureau::StructureError)
    exception.message.should == \
      "a section's :drawers key must have an array value if it is present (#{not_an_array}.class != Array)"
  end

  it 'does not error if a drawer list is empty' do
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
    exception.message.should == "all elements of section[:drawers] must be a hash (each representing a menu row) (#{not_a_hash}.class != Hash)"
  end

  it 'does not error if the drawer list is empty' do
    @structure.first[:drawers] = []
    exception = lambda{
      Bureau::Bureau.new(structure: @structure)
    }.should.not.raise Bacon::Error
  end

  it 'does not error if all drawers are valid (hashes)' do
    exception = lambda{
      Bureau::Bureau.new(structure: @structure)
    }.should.not.raise Bacon::Error
  end
end
