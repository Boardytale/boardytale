part of model;

@Typescript()
enum GameNavigationState {
  @JsonValue('findLobby')
  findLobby,
  @JsonValue('createGame')
  createGame,
  @JsonValue('inGame')
  inGame,
  @JsonValue('loading')
  loading,
  @JsonValue('inLobby')
  inLobby,
  @JsonValue('userPanel')
  userPanel,
  @JsonValue('login')
  login,
  @JsonValue('heroPanel')
  heroPanel,
}
