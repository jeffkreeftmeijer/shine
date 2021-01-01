import shine
import gleam/should

pub fn hello_world_test() {
  shine.hello_world()
  |> should.equal("Hello, from shine!")
}
