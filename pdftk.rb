require 'formula'

class PkgExtract < CurlDownloadStrategy
  def stage
    url_sha256 = Digest::SHA256.hexdigest(url)
    safe_system '/usr/bin/xar', '-xf', Dir["#{HOMEBREW_CACHE}/downloads/#{url_sha256}--*"].first
    Dir.mkdir "pdftk"
    safe_system "tar -xf *.pkg/Payload -C pdftk/."
  end
end

class Pdftk < Formula
  homepage 'http://www.pdflabs.com/tools/pdftk-server'
  url 'http://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/pdftk_server-2.02-mac_osx-10.11-setup.pkg',
    :using => PkgExtract
  sha256 'c33cf95151e477953cd57c1ea9c99ebdc29d75f4c9af0d5f947b385995750b0c'

  def install
    prefix.install Dir["pdftk/*"]
  end

  test do
    system "#{bin}/pdftk --version"
  end
end
