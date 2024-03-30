class Nsdg < Formula
  desc "Generates images of Nassi-Shneiderman diagrams from xml files"
  homepage "https://greenlightning.eu/nsdg"
  url "https://github.com/GreenLightning/nsdg/releases/download/v1.0/nsdg-1.0.zip"
  sha256 "d73e40d674f6a18056a9f2b7471b454eeac6ea474466f521f719dd74c3047a29"
  license "ISC"
  depends_on "openjdk@11"

  def install
    libexec.install "nsdg.jar"
    (pkgshare/"nsdg").install "data"
    bin.write_jar_script libexec/"nsdg.jar", "nsdg", java_version: "11"
  end

  test do
    Dir.mktmpdir do |tmpdir|
      cp "#{pkgshare}/nsdg/data/examples/quicksort.xml", "#{tmpdir}/quicksort.xml"
      Dir.chdir(tmpdir) do
        system "#{bin}/nsdg", "./quicksort.xml"
        assert_predicate Pathname.new("quicksort.png"), :exist?
      end
    end
  end
end
