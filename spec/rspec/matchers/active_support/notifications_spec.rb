# frozen_string_literal: true

RSpec.describe Rspec::Matchers::ActiveSupport::Notifications do
  it "has a version number" do
    expect(Rspec::Matchers::ActiveSupport::Notifications::VERSION).not_to be nil
  end

  context "whoopsie doopsies" do
    let(:event) { "my_event.lib" }
    let(:code) do
      lambda {
        ::ActiveSupport::Notifications.instrument(event)
      }
    end

    context "when mistyping the event name" do
      it "does not match the event" do
        expect { code.call }.to emit_event("my-event.lib").exactly(0).times
      end
    end

    context "when mistyping the event regex" do
      it "does not match the event" do
        expect { code.call }.to emit_event(/myevent.lib/).exactly(0).times
      end
    end
  end

  context "when using strings" do
    let(:event) { "my_event.lib" }
    let(:code) do
      lambda {
        ::ActiveSupport::Notifications.instrument(event)
      }
    end

    it "captures the event" do
      expect { code.call }.to emit_event(event)
    end
  end

  context "when using regex" do
    let(:event) { "my_event.lib" }
    let(:code) do
      lambda {
        ::ActiveSupport::Notifications.instrument(event)
      }
    end

    it "captures the event" do
      expect { code.call }.to emit_event(/.+\.lib$/)
    end
  end

  context "when capturing counts" do
    let(:event) { "my_event.lib" }
    let(:code) do
      lambda {
        ::ActiveSupport::Notifications.instrument(event)
      }
    end

    it "matches with once" do
      expect { code.call }.to emit_event(/.+\.lib$/).exactly(:once)
    end

    it "matches with twice" do
      expect { 2.times { code.call } }.to emit_event(/.+\.lib$/).exactly(:twice)
    end

    it "matches with thrice" do
      expect { 3.times { code.call } }.to emit_event(/.+\.lib$/).exactly(:thrice)
    end

    it "matches with zero" do
      expect {}.to emit_event(/.+\.lib$/).exactly(0).times
    end
  end

  context "when filtering using #with" do
    let(:event) { "my_event.lib" }
    let(:code) do
      lambda {
        ::ActiveSupport::Notifications.instrument(event, {key: :value})
        ::ActiveSupport::Notifications.instrument(event, {key: :anothervalue})
      }
    end

    it "emits two events" do
      expect { code.call }.to emit_event(/.+\.lib$/).twice
    end

    it "matches once with payload filter" do
      expect { code.call }.to emit_event(/.+\.lib$/).with({key: :value}).exactly(:once)
    end

    context "partial matches" do
      let(:code) do
        lambda {
          ::ActiveSupport::Notifications.instrument(event, {key: :value, num: 1})
          ::ActiveSupport::Notifications.instrument(event, {key: :anothervalue, num: 3})
        }
      end

      it "matches once with payload filter" do
        expect { code.call }.to emit_event(/.+\.lib$/).with(hash_including(num: 3)).exactly(:once)
      end
    end
  end
end
