# encoding: utf-8
require 'nokogiri'
require 'json'
module Helpers
	class Parser

		attr_accessor :candidati, :candidat
		def parse(page)
			nbsp = Nokogiri::HTML("&nbsp;").text
			doc = Nokogiri::HTML(page)
			doc.css('table tr[hint]').to_enum.with_index(0).each do |tr, i|
				if(i.even?)
					@candidat = Candidat.new
					tds = tr.css('td')
					script = tr.css('script')
					matches = script[0].inner_html.match(/LuatDePeBacalaureatEduRo\["(.*?)"\]="(.*?)";LuatDePe_BacalaureatEduRo\["(.*?)"\]="(.*?)";Luat_DePe_BacalaureatEduRo\["(.*?)"\]="(.*?)"/)

					@candidat.nume = matches[2].gsub('<br>','')
					@candidat.unitate = tds[2].css('a').inner_html.gsub('&amp;nbsp','').gsub(/\xFF/, '')
					@candidat.judet = tds[3].css('a').inner_html.gsub('&amp;nbsp','')
					@candidat.promotieAnterioara = tds[4].inner_html.gsub('&amp;nbsp','')
					@candidat.formaInvatamant = tds[5].inner_html.gsub('&amp;nbsp','')
					@candidat.specializare = tds[6].inner_html.gsub('&amp;nbsp','')
					@candidat.lbRomana.competente = tds[7].inner_html.gsub('&amp;nbsp','')
					@candidat.lbRomana.scris = tds[8].inner_html.gsub('&amp;nbsp','')
					@candidat.lbRomana.contestatie = tds[9].inner_html.gsub('&amp;nbsp','')
					@candidat.lbRomana.notaFinala = tds[10].inner_html.gsub('&amp;nbsp','')
					@candidat.lbMaterna.limba = tds[11].inner_html.gsub('&amp;nbsp','')
					@candidat.lbModerna.limba = tds[12].inner_html.gsub('&amp;nbsp','')
					@candidat.obligatorie.disciplina = tds[14].inner_html.gsub('&amp;nbsp','')
					@candidat.alegere.disciplina = tds[15].inner_html.gsub('&amp;nbsp','')
					@candidat.competenteDigitale = tds[16].inner_html.gsub('&amp;nbsp','')
					@candidat.lbModerna.nota = tds[13].inner_html.gsub('&amp;nbsp','')
					@candidat.medie = matches[4]
					@candidat.rezultat = matches[6]
				else
					tds = tr.css('td')
					@candidat.lbMaterna.competente = tds[0].inner_html.gsub('&amp;nbsp','')
					@candidat.lbMaterna.scris = tds[1].inner_html.gsub('&amp;nbsp','')
					@candidat.lbMaterna.contestatie = tds[2].inner_html.gsub('&amp;nbsp','')
					@candidat.lbMaterna.notaFinala = tds[3].inner_html.gsub('&amp;nbsp','')
					@candidat.obligatorie.nota = tds[4].inner_html.gsub('&amp;nbsp','')
					@candidat.obligatorie.contestatie = tds[5].inner_html.gsub('&amp;nbsp','')
					@candidat.obligatorie.notaFinala = tds[6].inner_html.gsub('&amp;nbsp','')
					@candidat.alegere.nota = tds[7].inner_html.gsub('&amp;nbsp','')
					@candidat.alegere.contestatie = tds[8].inner_html.gsub('&amp;nbsp','')
					@candidat.alegere.notaFinala = tds[9].inner_html.gsub('&amp;nbsp','')

					# puts @candidat.attributes#to_json
					# exit()

					entry = {}


					entry["Nume"] = @candidat.nume
					entry["Unitate"] = @candidat.unitate
					entry["Judet"] = @candidat.judet
					entry["Promotie anterioara"]=  @candidat.promotieAnterioara
					entry["Forma invatamant"]=  @candidat.formaInvatamant
					entry["Specializare" ] = @candidat.specializare
					entry["Competente digitale"] =  @candidat.competenteDigitale
					entry["Medie"] = @candidat.medie
					entry["Rezultat"] = @candidat.rezultat

					entry["lbRomana"]={}
					entry["lbRomana"]["Competente"] = @candidat.lbRomana.competente
					entry["lbRomana"]["Scris"] = @candidat.lbRomana.scris
					entry["lbRomana"]["Contestatie"] = @candidat.lbRomana.contestatie
					entry["lbRomana"]["Nota finala"] =  @candidat.lbRomana.notaFinala

					entry["lbMaterna"]={}
					entry["lbMaterna"]["Limba"] = @candidat.lbMaterna.limba
					entry["lbMaterna"]["Competente"] = @candidat.lbMaterna.competente
					entry["lbMaterna"]["Scris"] = @candidat.lbMaterna.scris
					entry["lbMaterna"]["Contestatie"] = @candidat.lbMaterna.contestatie
					entry["lbMaterna"]["Nota finala"] =  @candidat.lbMaterna.notaFinala

					entry["lbModerna"]={}
					entry["lbModerna"]["Limba"] = @candidat.lbModerna.limba
					entry["lbModerna"]["Nota"] = @candidat.lbModerna.nota

					entry["obligatorie"]={}
					entry["obligatorie"]["Disciplina"] = @candidat.obligatorie.disciplina
					entry["obligatorie"]["Nota"] = @candidat.obligatorie.nota
					entry["obligatorie"]["Contestatie"] = @candidat.obligatorie.contestatie
					entry["obligatorie"]["Nota finala"] =  @candidat.obligatorie.notaFinala

					entry["alegere"]={}
					entry["alegere"]["Disciplina"] = @candidat.alegere.disciplina
					entry["alegere"]["Nota"] = @candidat.alegere.nota
					entry["alegere"]["Contestatie"] = @candidat.alegere.contestatie
					entry["alegere"]["Nota finala"] =  @candidat.alegere.notaFinala

					puts entry
					exit()

				end
			end
		end
	end
end