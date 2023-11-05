open util/boolean

one sig RedeSocial{
  usuarios: set Usuario,
  contas: set Perfil
}

sig Publicacao{
  autores: set Perfil
}

sig Perfil{
  ativo: one Bool,
  dono: one Usuario,
  publicacoes: set Publicacao
}

sig Usuario{
  ativo: one Bool,
  amizadesAtivas: set Usuario,
  amizadesInativas: set Usuario,
  perfis: some Perfil
}

pred restringeAmizade[u: Usuario]{
  u not in u.^amizadesAtivas and u not in u.^amizadesInativas
}

fact "amizades diferente de si mesmo"{
    all u: Usuario | restringeAmizade[u]
}

fact "usuarios e perfil dentro de RedeSocial"{
  all u:Usuario, p:Perfil, r:RedeSocial | u in r.usuarios and p in r.contas 
}

// usuários inativos não possuem amizades
pred semAmizades[u1:Usuario, u2:Usuario]{
  (!(u2 in u1.amizadesAtivas) and !(u1 in u2.amizadesAtivas))
}

fact "usuarios inativos sem amizades"{
  all u1: Usuario | boolean/isFalse[u1.ativo] implies some u2: Usuario | semAmizades[u1, u2]
}

/*
se um usuário está inativo, podemos considerar 
todos os seus perfis como inativos
*/
fact "usuarios inativos com perfis inativos"{
  all u:Usuario, p:Perfil | boolean/isFalse[u.ativo] implies u in p.dono implies boolean/False in p.ativo
}

// postagens devem estar associadas a perfis ativos
pred restringePostagens[p:Publicacao]{
  
}

fact "postagens relacionadas a perfis ativos"{
  all p:Publicacao | restringePostagens[p]
}

/*
usuário pode publicar conteúdo de texto 
em seu perfil ou nos perfis de seus amigos.
*/
fact "usuario tem acesso a publicar texto em perfil de amigos"{
  /*
se p1 e p2 estao em autores de publicacao, p1 e p2 sao amigos ativos

fun inferiores[r: Recurso]: set Recurso{
    {r1: Recurso | r in r1.^superior}
}

fact "usuario acessa hierarquia"{
    all u: Usuario, r:Recurso | r in u.acessa implies inferiores[r] in u.acessa  
}
*/
}


run{} for 2