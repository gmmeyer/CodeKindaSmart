require 'spec_helper'

describe Document do
	
	describe 'Validations' do
		let(:document) do
			d = Document.create(title: 'Lorem', body: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Consequuntur, nostrum quam quod at eaque rem mollitia provident maxime culpa exercitationem debitis molestiae ad nisi praesentium autem nobis sequi dolorum natus?', user_id: 3)
			Document.find d.id
		end
		it 'will not save a document wthout a unique title' do
			dd = Document.new(title: 'Lorem', body: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aliquid, itaque, nam, corporis excepturi quis distinctio officiis aut nesciunt placeat quo qui quibusdam labore recusandae nihil sapiente debitis eos vero. Ablig.", user_id: 4)
			puts dd.valid?
			dd.valid?.should be_false 
		end
		it 'will not save a document without a title' do
		end
		it 'will not save a document without a body' do
		end
		it 'will not save a document without a user_id' do
		end
	end

end