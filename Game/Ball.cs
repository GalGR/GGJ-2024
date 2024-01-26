using Godot;
using System;

public class Ball : Position2D
{
	public Vector2 pivot_point;
	public Vector2 start_position;
	public float arm_length;
	public float angle;

	[Export] public float gravity = 0.4f * 60.0f;
	[Export] public float damping = 0.995f;

	public float angular_velocity = 0.0f;
	public float angular_acceleration = 0.0f;

	public bool ball_active = false;

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		start_position = GlobalPosition;
	}

	public void init_anchor(Node2D pivot_node)
	{
		start_position = GlobalPosition;
		// point the pendulum rotates around
		pivot_point = pivot_node.GlobalPosition;
		arm_length = Vector2.Zero.DistanceTo(start_position - pivot_point);
		angle = -Vector2.Down.AngleTo(start_position - pivot_point);
		angular_velocity = 0.0f;
		angular_acceleration = 0.0f;
	}

	public void set_active(bool active)
	{
		ball_active = active;
	}

	public void process_velocity(float delta)
	{
		angular_acceleration = ((-gravity*delta) / arm_length) *(float)Math.Sin(angle);	// Calculate acceleration (see: http://www.myphysicslab.com/pendulum1.html)
		angular_velocity += angular_acceleration;				// Increment velocity
		angular_velocity *= damping;								// Arbitrary damping
		angle += angular_velocity;								// Increment angle

		start_position = pivot_point + new Vector2(arm_length*(float)Math.Sin(angle), arm_length*(float)Math.Cos(angle));
		GlobalPosition = start_position;
	}

	public void add_angular_velocity(float force)
	{
		angular_velocity += force;
	}

	public override void _PhysicsProcess(float delta)
	{
		game_input();

		if (ball_active)
			process_velocity(delta);
		Update();
	}

	public void game_input()
	{
		float dir = 0.0f;
		if (Input.IsActionJustPressed("right"))
			dir += 1.0f;
		else if (Input.IsActionJustPressed("left"))
			dir -= 1.0f;
		add_angular_velocity(dir * 0.02f); 						// give a kick to the swing
	}
}
