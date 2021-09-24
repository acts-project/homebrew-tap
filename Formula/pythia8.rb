# taken from https://github.com/davidchall/homebrew-hep/blob/master/Formula/pythia.rb
class Pythia8 < Formula
  desc "Monte Carlo event generator"
  homepage "https://pythia.org/"
  url "https://pythia.org/download/pythia82/pythia8243.tgz"
  version "8.243"
  sha256 "067219fb737bfd379ddb602b609ff5cd04f0569782f8d9d59e403264fd8a21f3"

  def install
    args = %W[
      --prefix=#{prefix}
      --enable-shared
    ]

    system "./configure", *args
    system "make", "install"
  end

  test do
    system "true"
  end
end
