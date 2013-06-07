# encoding: cp850
require 'nokogiri'
require 'json'
module Helpers
	class Parser

		attr_accessor :candidati, :candidat
		def parse(page)

			nbsp = Nokogiri::HTML("&nbsp;").text
			doc = Nokogiri::HTML(page)
			@canditati = []
			doc.css('table tr[hint]').to_enum.with_index(0).each do |tr, i|
				if(i.even?)

					@candidat = Candidat.new
					tds = tr.css('td')
					script = tr.css('script')
					matches = script[0].inner_html.match(/LuatDePeBacalaureatEduRo\["(.*?)"\]="(.*?)";LuatDePe_BacalaureatEduRo\["(.*?)"\]="(.*?)";Luat_DePe_BacalaureatEduRo\["(.*?)"\]="(.*?)"/)
					#'&amp;nbsp'
					@candidat.nume = matches[2].gsub('<br>','')
					@candidat.unitate = tds[2].css('a').inner_html.gsub(nbsp,'').gsub(/"/,"'")#.gsub(/\xFF/, '')
					@candidat.judet = tds[3].css('a').inner_html.gsub(nbsp,'')#.gsub(/\xFF/, '')
					@candidat.promotieAnterioara = tds[4].inner_html.gsub(nbsp,'')#.gsub(/\xFF/, '')
					@candidat.formaInvatamant = tds[5].inner_html.gsub(nbsp, '')#.gsub(/\xFF/, '')

					@candidat.specializare = tds[6].inner_html.gsub(nbsp,'').gsub(/\xFF/, '')
					@candidat.lbRomana.competente = tds[7].inner_html.gsub(nbsp,'').gsub(/\xFF/, '')
					@candidat.lbRomana.scris = tds[8].inner_html.gsub(nbsp,'').gsub(/\xFF/, '')
					@candidat.lbRomana.contestatie = tds[9].inner_html.gsub(nbsp,'').gsub(/\xFF/, '')
					@candidat.lbRomana.notaFinala = tds[10].inner_html.gsub(nbsp,'').gsub(/\xFF/, '')
					@candidat.lbMaterna.limba = tds[11].inner_html.gsub(nbsp,'').gsub(/\xFF/, '')
					@candidat.lbModerna.limba = tds[12].inner_html.gsub(nbsp,'').gsub(/\xFF/, '')
					@candidat.obligatorie.disciplina = tds[14].inner_html.gsub(nbsp,'').gsub(/\xFF/, '')
					@candidat.alegere.disciplina = tds[15].inner_html.gsub(nbsp,'').gsub(/\xFF/, '')
					@candidat.competenteDigitale = tds[16].inner_html.gsub(nbsp,'').gsub(/\xFF/, '')
					@candidat.lbModerna.nota = tds[13].inner_html.gsub(nbsp,'').gsub(/\xFF/, '')
					@candidat.medie = matches[4]
					@candidat.rezultat = matches[6]#.gsub(/\xC5/,'s').gsub(/\x9F/,'')
				else
					tds = tr.css('td')
					@candidat.lbMaterna.competente = tds[0].inner_html.gsub(nbsp,'').gsub(/\xFF/, '')
					@candidat.lbMaterna.scris = tds[1].inner_html.gsub(nbsp,'').gsub(/\xFF/, '')
					@candidat.lbMaterna.contestatie = tds[2].inner_html.gsub(nbsp,'').gsub(/\xFF/, '')
					@candidat.lbMaterna.notaFinala = tds[3].inner_html.gsub(nbsp,'').gsub(/\xFF/, '')
					@candidat.obligatorie.nota = tds[4].inner_html.gsub(nbsp,'').gsub(/\xFF/, '')
					@candidat.obligatorie.contestatie = tds[5].inner_html.gsub(nbsp,'').gsub(/\xFF/, '')
					@candidat.obligatorie.notaFinala = tds[6].inner_html.gsub(nbsp,'').gsub(/\xFF/, '')
					@candidat.alegere.nota = tds[7].inner_html.gsub(nbsp,'').gsub(/\xFF/, '')
					@candidat.alegere.contestatie = tds[8].inner_html.gsub(nbsp,'').gsub(/\xFF/, '')
					@candidat.alegere.notaFinala = tds[9].inner_html.gsub(nbsp,'').gsub(/\xFF/, '')

					entry = {}


					entry["Nume"] = @candidat.nume
					entry["Unitate"] = @candidat.unitate
					entry["Judet"] = @candidat.judet
					entry["Promotie_anterioara"]=  @candidat.promotieAnterioara
					entry["Forma_invatamant"]=  @candidat.formaInvatamant
					entry["Specializare" ] = @candidat.specializare
					entry["Competente_digitale"] =  @candidat.competenteDigitale
					entry["Medie"] = @candidat.medie
					entry["Rezultat"] = @candidat.rezultat

					entry["lbRomana_Competente"] = @candidat.lbRomana.competente
					entry["lbRomana_Scris"] = @candidat.lbRomana.scris
					entry["lbRomana_Contestatie"] = @candidat.lbRomana.contestatie
					entry["lbRomana_NotaFinala"] =  @candidat.lbRomana.notaFinala

					entry["lbMaterna_Limba"] = @candidat.lbMaterna.limba
					entry["lbMaterna_Competente"] = @candidat.lbMaterna.competente
					entry["lbMaterna_Scris"] = @candidat.lbMaterna.scris
					entry["lbMaterna_Contestatie"] = @candidat.lbMaterna.contestatie
					entry["lbMaterna_NotaFinala"] =  @candidat.lbMaterna.notaFinala


					entry["lbModerna_Limba"] = @candidat.lbModerna.limba
					entry["lbModerna_Nota"] = @candidat.lbModerna.nota


					entry["obligatorie_Disciplina"] = @candidat.obligatorie.disciplina
					entry["obligatorie_Nota"] = @candidat.obligatorie.nota
					entry["obligatorie_Contestatie"] = @candidat.obligatorie.contestatie
					entry["obligatorie_Nota finala"] =  @candidat.obligatorie.notaFinala


					entry["alegere_Disciplina"] = @candidat.alegere.disciplina
					entry["alegere_Nota"] = @candidat.alegere.nota
					entry["alegere_Contestatie"] = @candidat.alegere.contestatie
					entry["alegere_NotaFinala"] =  @candidat.alegere.notaFinala

					@canditati.push( entry )
				end
			end
		end
		def getCanditati
			return @canditati.to_json
		end
		def writeToFile(filename)
			File.open( 'json/' + filename + '.json', 'w' ) { |file| file.puts ( @canditati.to_json ) }
		end
	end
end