states = [
  {name: "Goiás", uf: "GO", slug: "goias"},
  {name: "Minas Gerais", uf: "MG", slug: "minas-gerais"},
  {name: "Acre", uf: "AC", slug: "acre"},
  {name: "Alagoas", uf: "AL", slug: "alagoas"},
  {name: "Amapá", uf: "AP", slug: "amapa"},
  {name: "Amazonas", uf: "AM", slug: "amazonas"},
  {name: "Bahia", uf: "BA", slug: "bahia"},
  {name: "Ceará", uf: "CE", slug: "ceara"},
  {name: "Distrito Federal", uf: "DF", slug: "distrito-federal"},
  {name: "Espírito Santo", uf: "ES", slug: "espirito-santo"},
  {name: "Maranhão", uf: "MA", slug: "maranhao"},
  {name: "Mato Grosso", uf: "MT", slug: "mato-grosso"},
  {name: "Mato Grosso do Sul", uf: "MS", slug: "mato-grosso-do-sul"},
  {name: "Pará", uf: "PA", slug: "para"},
  {name: "Paraíba", uf: "PB", slug: "paraiba"},
  {name: "Paraná", uf: "PR", slug: "parana"},
  {name: "Pernambuco", uf: "PE", slug: "pernambuco"},
  {name: "Piauí", uf: "PI", slug: "piaui"},
  {name: "Rio de Janeiro", uf: "RJ", slug: "rio-de-janeiro"},
  {name: "Rio Grande do Norte", uf: "RN", slug: "rio-grande-do-norte"},
  {name: "Rio Grande do Sul", uf: "RS", slug: "rio-grande-do-sul"},
  {name: "Rondônia", uf: "RO", slug: "rondonia"},
  {name: "Roraima", uf: "RR", slug: "roraima"},
  {name: "Santa Catarina", uf: "SC", slug: "santa-catarina"},
  {name: "São Paulo", uf: "SP", slug: "sao-paulo"},
  {name: "Sergipe", uf: "SE", slug: "sergipe"},
  {name: "Tocantins", uf: "TO", slug: "tocantins"}
]

states.each do |state|
  State.create!(name: state[:name], slug: state[:slug], uf: state[:uf])
end

puts "#{State.count} estados foram criados"
