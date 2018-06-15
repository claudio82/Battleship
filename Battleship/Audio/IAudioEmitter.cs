﻿using Microsoft.Xna.Framework;

namespace Battleship.Audio
{
    public interface IAudioEmitter
    {
        Vector3 Position { get; }
        Vector3 Forward { get; }
        Vector3 Up { get; }
        Vector3 Velocity { get; }
    }
}
