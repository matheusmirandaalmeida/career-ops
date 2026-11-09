# Custom Instructions -- career-ops

<!-- Estrutura de modes/_custom.template.md. -->

## House Rules

- Este ambiente é exclusivo da área tecnologia. Ler e gravar dados somente no DATA_ROOT selecionado; modelos e núcleo continuam na instalação única.
- Não carregar currículo, critérios, relatórios ou tracker do outro perfil como fontes.
- Perfil em preparação: confirmar os dados faltantes antes de avaliar vagas ou gerar materiais de candidatura. Existência dos arquivos não significa onboarding concluído.
- Manter empresas, cargos oficiais, datas e formação consistentes entre currículos, sem consultar o outro ambiente automaticamente; solicitar confirmação de atualizações factuais comuns.

## Custom Workflows

- Antes de qualquer fluxo, conferir o DATA_ROOT ativo. Usar apenas o currículo e os critérios desta área.

## Output Preferences

- Português do Brasil; respostas curtas e diretas.
- Currículo adaptado por vaga, usando apenas fatos confirmados.

## Off-Limits

- Não inventar qualificações, experiências, cursos, autoria ou métricas.
- Não iniciar buscas, instalar dependências, enviar dados ou candidaturas sem solicitação.
- Não alterar arquivos do núcleo para personalizar o perfil.

## Triagem de descoberta — Etapa 10.4

- Aplicar estas regras na triagem do agente; elas não criam classificação automática em `scan.mjs`. Manter a coleta original em memória, sem remover grupos da fonte; qualquer gravação exige autorização da execução.
- Classificar por evidência do título, requisitos e tipo contratual: gerais; exclusivas PcD; afirmativas com critérios de elegibilidade; aprendiz; estágio; outras modalidades (PJ, temporário, autônomo etc.). Permitir etiquetas simultâneas, como estágio afirmativo. Não duplicar a contagem da mesma vaga entre listas.
- PcD exclusiva requer restrição explícita; vaga afirmativa requer critério expresso. Texto genérico de diversidade ou benefícios de saúde não caracteriza ação afirmativa nem atuação no setor da saúde. Não presumir condição, idade ou elegibilidade do candidato. Guardar evidência e condição a confirmar.
- Ranking principal: vagas gerais com CLT explicitamente confirmado. Manter lista de gerais com regime a confirmar; `vacancy_type_effective`/efetivo não basta para afirmar CLT. PcD/afirmativas, aprendizagem, estágio e outras modalidades ficam em listas próprias. Estágio em TI permanece relevante e recebe ranking separado.
- Antes de escolher até 15 vagas, separar modalidades e elegibilidade: benefícios médicos não podem elevar artificialmente o ranking por setor. Priorizar aderência real a TI, nível júnior, dados disponíveis e remoto/híbrido elegível no Brasil. Não preencher o ranking principal com vagas restritas quando faltarem opções gerais.
- Júnior/junior/Jr e auxiliar/assistente/técnico não significam automaticamente o mesmo nível em toda profissão. PL/pleno, SR/sênior e liderança explícita não devem competir com júnior. Níveis I/II/III e "especialista" sem qualificação clara exigem revisão do escopo, sem inferir senioridade só do número ou termo.
- São Paulo capital: consultar o campo municipal original da API e exigir cidade normalizada exatamente São Paulo, ou endereço municipal confirmado na página oficial. Estado São Paulo, UF SP, sede da empresa ou nome da fonte não comprovam município. Divergência API/página, município ausente ou modalidade conflitante vão para revisão geográfica, fora do ranking confirmado. Não considerar outras cidades como capital.
- Remoto: confirmar elegibilidade para trabalhar no Brasil pela fonte; "remoto" isolado fica em revisão. Híbrido/presencial requer capital confirmada; presencial na capital continua permitido. Preferir remoto/híbrido entre vagas comparáveis, sem ignorar requisitos ou regime.
- O normalizador Gupy não conserva `city` e `type` separadamente. Em consultas controladas, conferir a resposta original via transporte oficial ou a página da vaga; não inventar `field_filters` para campos ausentes nem confiar apenas em `location` concatenado.
- Priorizar publicações dos últimos sete dias; datas ausentes ficam em revisão e não são inventadas. Manter remuneração ausente; priorizar CLT bruto mensal desde R$ 2.400, referência R$ 2.500, sem teto. Não tratar isso como corte, nem comparar bolsa/PJ diretamente com CLT.
- Deduplicar primeiro por identificador com namespace da fonte/empresa e por URL canônica sem parâmetros de rastreamento, preservando parâmetros necessários à identidade. Títulos iguais com IDs distintos não bastam para excluir. Anúncios com empresa, cargo ou URL insuficientes ficam em revisão; encerramento só com evidência explícita. Disponibilidade não verificada é desconhecida.
- Próxima pesquisa: um perfil e uma fonte por execução, em memória/sem gravação. Até duas páginas por termo Gupy, orçamento total de até dez páginas para os cinco termos, parada por recência/fim do feed e até 15 vagas na triagem detalhada, com listas separadas e contagens transparentes. Não repetir consultas só para preencher a cota; parar diante de bloqueio de acesso.
- Expansão ATS: preservar as consultas existentes; confirmar primeiro URL oficial e provedor Greenhouse, Lever, Ashby, SmartRecruiters ou Workday. Workday precisa de URL/site verificável. Não inventar tenant, slug ou empresa, nem executar descoberta de empresas em lote sem solicitação.
