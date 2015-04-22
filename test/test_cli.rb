require 'minitest_helper'
require 'punky_brewster/cli'

class TestCLI < Minitest::Test
  def test_version_command
    assert_output(/#{PunkyBrewster::VERSION}/) do
      PunkyBrewster::CLI.new.version
    end
  end

  def test_list_command
    VCR.use_cassette("whats-pouring") do
      output = strip_heredoc(<<-POURING)
        8 WIRED HOPWIRED                  $16.00/L  7.3%
        ALL CHIEFS , NO INDIANS           $14.00/L  6.0%
        CROUCHER LOW RIDER IPA            $12.00/L  2.7%
        DALES ESB (EXTRA SPECIAL BITTER)  $14.00/L  5.6%
        EPIC PALE ALE                     $14.00/L  5.4%
        FUNK ESTATE NZPA FRESH HOP        $16.00/L  5.5%
        GARAGE PROJECT HAPI DAZE          $14.00/L  4.2%
        GOLDEN ALE FRESH HOP              $16.00/L  4.5%
        GOLDEN EAGLE BIG YANK             $16.00/L  7.5%
        INVERCARGILL PITCHBLACK STOUT     $13.50/L  4.5%
        MIKE'S VANILLA COFFEE PORTER      $16.00/L  8.0%
        MUSSEL INN CAPTAIN COOKER         $12.50/L  5.7%
        PANHEAD PILSENER                  $14.00/L  5.2%
        PARROTDOG BITTER BITCH IPA        $15.50/L  5.8%
        PARROTDOG BLOODHOUND RED ALE      $15.50/L  6.3%
        PECKHAM'S MOUTERE CIDER           $14.00/L  5.9%
        RAINDOGS OXYMORON BLACK IPA       $14.50/L  7.0%
        RENAISSANCE PARADOX PILSENER      $14.00/L  4.0%
        THREE BOYS WHEAT BEER             $14.00/L  5.0%
        TUATARA ITI AMERICAN PALE ALE     $12.50/L  5.8%
        VALKYRIE FRIGG RED PILSENER       $13.50/L  5.0%
      POURING

      assert_output(output) { cli.invoke(:list) }
    end
  end

  def test_list_command_sort_option
    VCR.use_cassette("whats-pouring") do
      output = strip_heredoc(<<-POURING)
        CROUCHER LOW RIDER IPA            $12.00/L  2.7%
        TUATARA ITI AMERICAN PALE ALE     $12.50/L  5.8%
        MUSSEL INN CAPTAIN COOKER         $12.50/L  5.7%
        VALKYRIE FRIGG RED PILSENER       $13.50/L  5.0%
        INVERCARGILL PITCHBLACK STOUT     $13.50/L  4.5%
        RENAISSANCE PARADOX PILSENER      $14.00/L  4.0%
        ALL CHIEFS , NO INDIANS           $14.00/L  6.0%
        PECKHAM'S MOUTERE CIDER           $14.00/L  5.9%
        DALES ESB (EXTRA SPECIAL BITTER)  $14.00/L  5.6%
        THREE BOYS WHEAT BEER             $14.00/L  5.0%
        GARAGE PROJECT HAPI DAZE          $14.00/L  4.2%
        EPIC PALE ALE                     $14.00/L  5.4%
        PANHEAD PILSENER                  $14.00/L  5.2%
        RAINDOGS OXYMORON BLACK IPA       $14.50/L  7.0%
        PARROTDOG BLOODHOUND RED ALE      $15.50/L  6.3%
        PARROTDOG BITTER BITCH IPA        $15.50/L  5.8%
        GOLDEN ALE FRESH HOP              $16.00/L  4.5%
        MIKE'S VANILLA COFFEE PORTER      $16.00/L  8.0%
        GOLDEN EAGLE BIG YANK             $16.00/L  7.5%
        FUNK ESTATE NZPA FRESH HOP        $16.00/L  5.5%
        8 WIRED HOPWIRED                  $16.00/L  7.3%
      POURING

      assert_output(output) { cli.invoke(:list, [], sort: 'price') }
    end
  end

  def test_list_command_holla_for_dollar_option
    VCR.use_cassette("whats-pouring") do
      output = strip_heredoc(<<-POURING)
        MIKE'S VANILLA COFFEE PORTER      $16.00/L  8.0%  0.50%/$
        RAINDOGS OXYMORON BLACK IPA       $14.50/L  7.0%  0.48%/$
        GOLDEN EAGLE BIG YANK             $16.00/L  7.5%  0.47%/$
        MUSSEL INN CAPTAIN COOKER         $12.50/L  5.7%  0.46%/$
        8 WIRED HOPWIRED                  $16.00/L  7.3%  0.46%/$
        TUATARA ITI AMERICAN PALE ALE     $12.50/L  5.8%  0.46%/$
        ALL CHIEFS , NO INDIANS           $14.00/L  6.0%  0.43%/$
        PECKHAM'S MOUTERE CIDER           $14.00/L  5.9%  0.42%/$
        PARROTDOG BLOODHOUND RED ALE      $15.50/L  6.3%  0.41%/$
        DALES ESB (EXTRA SPECIAL BITTER)  $14.00/L  5.6%  0.40%/$
        EPIC PALE ALE                     $14.00/L  5.4%  0.39%/$
        PARROTDOG BITTER BITCH IPA        $15.50/L  5.8%  0.37%/$
        VALKYRIE FRIGG RED PILSENER       $13.50/L  5.0%  0.37%/$
        PANHEAD PILSENER                  $14.00/L  5.2%  0.37%/$
        THREE BOYS WHEAT BEER             $14.00/L  5.0%  0.36%/$
        FUNK ESTATE NZPA FRESH HOP        $16.00/L  5.5%  0.34%/$
        INVERCARGILL PITCHBLACK STOUT     $13.50/L  4.5%  0.33%/$
        GARAGE PROJECT HAPI DAZE          $14.00/L  4.2%  0.30%/$
        RENAISSANCE PARADOX PILSENER      $14.00/L  4.0%  0.29%/$
        GOLDEN ALE FRESH HOP              $16.00/L  4.5%  0.28%/$
        CROUCHER LOW RIDER IPA            $12.00/L  2.7%  0.23%/$
      POURING

      assert_output(output) { cli.invoke(:list, [], holla_for_dollar: true) }
    end
  end

  def cli
    @cli ||= PunkyBrewster::CLI.new
  end

  def strip_heredoc(heredoc)
    indent = heredoc.scan(/^[ \t]*(?=\S)/).min.size || 0
    heredoc.gsub(/^[ \t]{#{indent}}/, '')
  end
end
