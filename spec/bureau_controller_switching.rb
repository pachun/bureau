# describe 'A Bureau' do
#   before do
#     @x = UIViewController.new
#     @y = UIViewController.new
#     @structure = [
#       {
#         drawers:
#         [
#           {target: nil, action: :something},
#           {controller: @x},
#         ]
#       },
#       {
#         drawers:
#         [
#           {target: nil, action: :something_else},
#           {controller: @y, active: true},
#         ]
#       },
#       {}
#     ]
#   end
# 
#   it 'starts up using the active controller' do
#     bureau = Bureau::Bureau.new(structure:@structure)
#     # bureau.active_option.controller.should == @y
#   end
# 
#   it "uses the first controller if an active one isn't specified" do
#     @structure[1][:drawers].last[:active] = false
#     bureau = Bureau::Bureau.new(structure:@structure)
#     # bureau.active_option.controller.should == @x
#   end
# end
