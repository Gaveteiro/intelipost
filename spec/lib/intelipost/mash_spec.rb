# frozen_string_literal: true

describe Intelipost::Mash do
  it 'will create a intelipost mash and check if it is a success response' do
    mash = Intelipost::Mash.new(status: 'OK')

    expect(mash.success?).to eq true
    expect(mash.failure?).to eq false
    expect(mash.all_messages).to eq nil
  end

  it 'will create a intelipost mash and check if it is a failure response' do
    mash = Intelipost::Mash.new(
      messages: [
        { text: 'some error message' },
        { text: 'some error message2' }
      ]
    )

    expect(mash.success?).to eq false
    expect(mash.failure?).to eq true
    expect(mash.all_messages).to eq 'some error message;some error message2'
  end

  it 'should override length to avoid conflict with Hash#length method' do
    mash = Intelipost::Mash.new(length: 42)
    expect(mash.length).to eq 42
  end

  it 'should override key to avoid conflict with Hash#key method' do
    mash = Intelipost::Mash.new(key: 'api-or-other-key')
    expect(mash.key).to eq 'api-or-other-key'
  end
end
