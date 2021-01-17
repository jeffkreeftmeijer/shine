import test_project
import gleam/should

pub fn hello_world_test() {
  test_project.hello_world()
  |> should.equal("Hello, from test_project!")
}
