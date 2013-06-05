require "base64"

class Decoder
	def initialize(encoded)
		@encoded = encoded
	end
	def encoded
		@encoded
	end

	def s0( p1, p2, p3 )
		l4 = p1
		l4 = l4.split(p2).join("_")
		l4 = l4.split(p3).join(p2)
		l4 = l4.split("_").join(p3)

		return l4
	end

	def s1( p1, p2 )
		return s0( p1, p2.downcase , p2.upcase )
	end

	def s2 ( p1 )
		l2 = p1
		l3 = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
		l4 = 0
		while (l4 < l3.length) do
			l2 = s1(l2, l3[l4] )
			l4 += 1
		end
		return l2
	end

	def s3()
		l1 = @encoded


		unless ( 1.nil? )
			l1 = s0(l1, "0", "O")

			l1 = s0(l1, "1", "l")
			l1 = s0(l1, "5", "S")
			l1 = s0(l1, "m", "s")
			l1 = s2(l1)

			return Base64.decode64(l1)
		end
		return 'esti cretin'
	end
end
