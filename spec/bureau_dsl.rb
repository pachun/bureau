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

  it 'shows a descriptive error if structure is not an array' do
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

  it 'shows a descriptive error if structure has a non-hash element' do
    not_a_hash = :not_a_hash
    @structure[1] = not_a_hash
    exception = lambda{
      Bureau::Bureau.new(structure: @structure)
    }.should.raise(Bureau::StructureError)
    exception.message.should == \
      "structures can only contain hashes (one for each table section) (#{not_a_hash}.class != Hash)"
  end

end
