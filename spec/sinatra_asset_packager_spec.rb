require 'spec_helper'

describe SinatraAssetPackager do
  subject { SinatraAssetPackager }

  describe "defaults" do
    let(:environment) { subject.environment }

    it { environment.should_not be_nil }
    it { environment.paths.length.should eq 4 }

    context "compile is true" do
      let(:environment) { subject.environment(true) }

      it { environment.should_not be_nil }
      it { environment.paths.length.should eq 4 }
    end
  end
end