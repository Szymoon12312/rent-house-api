module Gpdfs
  module Generators
    class LeaseAgreement < Base
      NUMBER_OF_PARAGRAPHS = 10
      LEASE_AGREMENT_TITLE = "UMOWA NAJMU LOKALU MIESZKALNEGO"

      def initialize(accommodation, renter, lease_params)
        super()
        @accommodation = accommodation
        @renter        = renter
        @lease_params  = lease_params
        @lease_data    = prefill_lease_data
        @key_prefiller = ->(data = nil, key = nil, number: 10) { data.fetch(key.to_sym)  { '.' * number } }
      end

      def self.call(accommodation = nil, renter = nil, lease_params = {})
        new(accommodation, renter, lease_params).call
      end

      private
      attr_reader :accommodation, :renter, :lease_data, :lease_params, :key_prefiller

      def build_content
        introduction
        (1..NUMBER_OF_PARAGRAPHS).each do |index|
          small_gap
          pdf.text "$#{index}", align: :center
          small_gap
          send(:"paragraph_#{index}")
        end
        #Signs
      end

      def header
        super(LEASE_AGREMENT_TITLE)
      end

      def introduction
        small_gap
        # pdf.text "Zawarta w dniu " + "." * 10 + " w " + "." * 20 + " pomiędzy " +
        #      "1. " + "." * 20 + " legitymującym się dowodem osobistym nr " + "." * 20 + ", " +
        #         "wydanym przez " + "." * 30 + ", zamieszkałym w " + "." * 30 +
        #       "przy ul. " + "." * 40 + ' zwanym w treści umowy „Wynajmującym", a ' +
        #       "2. " + "." * 20 + " legitymującym się dowodem osobistym nr " + "." * 20 +
        #       "wydanym przez " + "." * 30 + ", zamieszkałym w " + "." * 30 +
        #       "przy ul. " + "." * 30 + ' zwanym w treści umowy "Najemcą", o następującej
        #       treści: '
      end

      def prefill_lease_data
        return lease_params if accommodation.blank? && renter.blank?
        accommodation.leased_agreement_data(lease_params)
      end

      def paragraph_1
        pdf.text "Wynajmujący oświadcza, że jest właścicielem mieszkania położonego na #{key_prefiller.(lease_data[:accommodation], :flor)} piętrze"
      end

      def paragraph_2
        pdf.text "1. Wynajmujący wynajmuje i oddaje w użytkowanie Najemcy cały wymieniony w§ 1 lokal
              wraz z urządzeniami (meble, sprzęt RTV, sprzęt gospodarstwa domowego).
              2. Wykaz urządzeń wymienionych w pkt. 1 oraz opis stanu technicznego ww. lokalu stanowi
              załącznik nr 1 do niniejszej umowy.
              3. Obejmując przedmiot najmu Najemca nie wnosi zastrzeżeń do jego stanu technicznego."
      end

      def paragraph_3
        pdf.text "1. Czynsz najmu strony ustalają w wysokości ..................... zł (słownie ..............................
              ....................................... złotych) miesięcznie.
              2. Czynsz najmu płatny będzie z góry do dnia ................ każdego miesiąca do rąk
              Wynajmującego (przelewem na jego konto osobiste)."
      end

      def paragraph_4
        pdf.text "Strony ustalają, iż wszelkie koszty i świadczenia związane z eksploatacją lokalu
              mieszkalnego, przez czas trwania umowy, ponosić będzie Najemca."
      end

      def paragraph_5
        pdf.text "Najemcy nie wolno oddawać przedmiotu najmu w podnajem ani bezpłatne używanie osobom
              trzecim."
      end

      def paragraph_6
        pdf.text "Wszelkie adaptacje i ulepszenia przedmiotu wynajmu wymagają pisemnej zgody
              Wynajmującego."
      end

      def paragraph_7
        pdf.text "1. Po zakończeniu najmu Najemca zobowiązany jest zwrócić lokal wraz z wyposażeniem
              wstanie niepogorszonym, wynikającym z normalnej eksploatacji.
              2. Najemca wpłaca kaucję w wysokości ................ł (słownie .................................................
              ........................................... złotych), która podlega zwrotowi po przekazaniu lokalu w
              stanie niepogorszonym Wynajmującemu."
      end

      def paragraph_8
        pdf.text "Umowa niniejsza zawarta została na czas (nieokreślony -wówczas każdej ze stron przysługuje
              prawo wypowiedzenia w terminie .......... ) określony do dnia ................................................. i
              po upływie tego okresu przestaje obowiązywać, bez uprzedniego wypowiedzenia."
      end

      def paragraph_9
        pdf.text "Wszelkie zmiany i uzupełnienia umowy wymagają formy pisemnej, w formie aneksu."
      end

      def paragraph_10
        pdf.text "W sprawach nie uregulowanych niniejszą umową mają zastosowanie przepisy kodeksu
              cywilnego."
      end
    end
  end
end
