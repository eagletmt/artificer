RSpec.describe Artificer do
  describe 'Model.make' do
    it 'creates a record' do
      book = Book.make
      expect(book.title).to eq('foo')
      expect(book.page_count).to eq(321)
    end

    context 'when attributes are given' do
      it 'creates a record with given attributes' do
        book = Book.make(page_count: 1)
        expect(book.title).to eq('foo')
        expect(book.page_count).to eq(1)
      end
    end

    context "when blueprint file doesn't execute Model.blueprint" do
      it 'raises an error' do
        expect { User.make }.to raise_error(Artificer::ConfigurationError, /User\.blueprint/)
      end
    end

    context "when blueprint file doesn't exist" do
      it 'raises an error' do
        expect { Comment.make }.to raise_error(Artificer::ConfigurationError, %r{spec/blueprints/comment\.rb})
      end
    end
  end

  describe 'Model.blueprint' do
    context 'when arguments given' do
      it 'raises an error' do
        expect { User.blueprint { name 'name' } }.to raise_error(ArgumentError)
      end
    end

    context "when block isn't given" do
      it 'raises an error' do
        expect { User.blueprint { name } }.to raise_error(ArgumentError)
      end
    end
  end

  describe '.reload!' do
    it 'reloads blueprint definition' do
      Book.make
      Artificer.reload!
      expect(Book).to receive(:blueprint).and_call_original
      Book.make
    end

    context 'without .reload!' do
      it 'does not load blueprint each time' do
        Book.make
        expect(Book).to_not receive(:blueprint)
        Book.make
      end
    end
  end
end
