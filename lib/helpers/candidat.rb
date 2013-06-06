module Helpers
	class Candidat
		attr_accessor :nume, :unitate, :judet, :promotieAnterioara, :formaInvatamant, :specializare, :lbRomana, :lbMaterna,
					:lbModerna, :obligatorie, :alegere, :competenteDigitale, :medie, :rezultat

		class LbRomana
			attr_accessor :competente, :scris, :contestatie, :notaFinala
		end

		class LbMaterna
			attr_accessor :limba, :competente, :scris, :contestatie, :notaFinala
		end

		class LbModerna
			attr_accessor :limba, :nota
		end

		class Obligatorie
			attr_accessor :disciplina, :nota, :contestatie, :notaFinala
		end

		class Alegere
			attr_accessor :disciplina, :nota, :contestatie, :notaFinala
		end

		def initialize
			@lbRomana = LbRomana.new
			@lbMaterna = LbMaterna.new
			@lbModerna = LbModerna.new
			@obligatorie = Obligatorie.new
			@alegere = Alegere.new
		end
	end
end